from django.shortcuts import render
from rest_framework.views import APIView
from .serializers import RegisterSerializer
from rest_framework.response import Response
from rest_framework import status
# Create your views here.
class RegisterView(APIView):
    def post(self, request):
        ...
        serializer = RegisterSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({"message": "Registration successful."}, status=status.HTTP_201_CREATED)
        # Return only the first error as message
        error_message = list(serializer.errors.values())[0][0]
        return Response({"message": error_message}, status=status.HTTP_400_BAD_REQUEST)


from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth import get_user_model
from django.contrib.auth.hashers import check_password
from rest_framework_simplejwt.tokens import RefreshToken

User = get_user_model()

class EmailLoginView(APIView):
    def post(self, request):
        email = request.data.get('email')
        password = request.data.get('password')

        try:
            user = User.objects.get(email=email)
        except User.DoesNotExist:
            return Response({'error': 'Invalid email or password'}, status=status.HTTP_401_UNAUTHORIZED)

        if not check_password(password, user.password):
            return Response({'error': 'Invalid email or password'}, status=status.HTTP_401_UNAUTHORIZED)

        refresh = RefreshToken.for_user(user)
        return Response({
            'refresh': str(refresh),
            'access': str(refresh.access_token),
        }, status=status.HTTP_200_OK)
from rest_framework import status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from .models import UserData
from .serializers import UserDataSerializer

# POST → Create user data
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def create_user_data(request):
    user = request.user
    if hasattr(user, 'userdata'):
        return Response({"message": "Data already exists. Use PATCH to update."}, status=status.HTTP_400_BAD_REQUEST)

    serializer = UserDataSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save(user=user)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# PATCH → Update data linked to token
@api_view(['PATCH'])
@permission_classes([IsAuthenticated])
def update_user_data(request):
    user = request.user
    try:
        user_data = user.userdata
    except UserData.DoesNotExist:
        return Response({"message": "No data found. Use POST to create first."}, status=status.HTTP_404_NOT_FOUND)

    serializer = UserDataSerializer(user_data, data=request.data, partial=True)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)  # 201 Created as requested
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# GET → Fetch user data by token
@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_user_data(request):
    user = request.user
    try:
        user_data = user.userdata
    except UserData.DoesNotExist:
        return Response({"message": "No data found."}, status=status.HTTP_404_NOT_FOUND)

    serializer = UserDataSerializer(user_data)
    return Response(serializer.data, status=status.HTTP_200_OK)


from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.parsers import MultiPartParser, FormParser, JSONParser
from rest_framework import status
from .models import Symptoms
from .serializers import SymptomsSerializer

class SymptomsView(APIView):
    permission_classes = [IsAuthenticated]
    parser_classes = [MultiPartParser, FormParser, JSONParser]

    def post(self, request):
        serializer = SymptomsSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(user=request.user)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def get(self, request):
        symptoms = Symptoms.objects.filter(user=request.user).order_by('-created_at')
        serializer = SymptomsSerializer(symptoms, many=True)
        return Response(serializer.data)

    def patch(self, request):
        try:
            symptoms = Symptoms.objects.filter(user=request.user).latest('created_at')
        except Symptoms.DoesNotExist:
            return Response({"detail": "No record found."}, status=404)

        serializer = SymptomsSerializer(symptoms, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=400)

# views.py
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework import status
from .models import MedicalImage
from .serializers import MedicalImageSerializer

class MedicalImageUploadView(APIView):
    permission_classes = [IsAuthenticated]
    parser_classes = [MultiPartParser, FormParser]

    def post(self, request):
        serializer = MedicalImageSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(user=request.user)
            return Response(serializer.data, status=201)
        return Response(serializer.errors, status=400)

    def get(self, request):
        print("Current User:", request.user)
        images = MedicalImage.objects.filter(user=request.user)
        print("Found images:", images)
        serializer = MedicalImageSerializer(images, many=True)
        return Response(serializer.data)

# Separate view for deleting by ID
class MedicalImageDeleteView(APIView):
    permission_classes = [IsAuthenticated]

    def delete(self, request, pk):
        try:
            image = MedicalImage.objects.get(pk=pk, user=request.user)
            image.delete()
            return Response({"message": "Deleted"}, status=204)
        except MedicalImage.DoesNotExist:
            return Response({"error": "Not found"}, status=404)

from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from django.contrib.auth.models import User

class ChangePasswordView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        user = request.user
        old_password = request.data.get('old_password')
        new_password = request.data.get('new_password')

        if not user.check_password(old_password):
            return Response({'error': 'Old password is incorrect'}, status=400)

        if len(new_password) < 8:
            return Response({'error': 'New password must be at least 8 characters long'}, status=400)

        user.set_password(new_password)
        user.save()
        return Response({'message': 'Password changed successfully'}, status=200)

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from django.contrib.auth import get_user_model

User = get_user_model()

class DeleteAccountView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        user = request.user
        password = request.data.get('password')

        if not user.check_password(password):
            return Response({"error": "Incorrect password"}, status=400)

        user.delete()
        return Response({"message": "Account deleted successfully"}, status=200)
    
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth.hashers import make_password
from django.contrib.auth import get_user_model
from .models import PasswordResetOTP
from .utils import generate_otp, send_otp_email

User = get_user_model()


from django.contrib.auth.models import User
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import PasswordResetOTP  # your model for storing OTPs
from .utils import generate_otp, send_otp_email  # your custom OTP generator and email sender

class RequestPasswordResetOTP(APIView):
    def post(self, request):
        email = request.data.get("email")
        if not email:
            return Response({"error": "Email is required"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            user = User.objects.get(email=email)
        except User.DoesNotExist:
            return Response({"error": "Email not found"}, status=status.HTTP_404_NOT_FOUND)

        # Delete old OTPs
        PasswordResetOTP.objects.filter(email=email).delete()

        # Generate and send new OTP
        otp = generate_otp()
        PasswordResetOTP.objects.create(email=email, otp=otp)
        send_otp_email(email, otp)

        return Response({"message": "OTP sent to email"}, status=status.HTTP_200_OK)
    
class VerifyOTPAPIView(APIView):
    def post(self, request):
        otp = request.data.get("otp")
        email = request.data.get("email")

        if not otp or not email:
            return Response({"error": "Email and OTP are required"}, status=400)

        try:
            otp_entry = PasswordResetOTP.objects.get(email=email, otp=otp)
        except PasswordResetOTP.DoesNotExist:
            return Response({"error": "Invalid OTP"}, status=400)

        if otp_entry.is_expired():
            otp_entry.delete()
            return Response({"error": "OTP expired"}, status=400)

        request.session["reset_email"] = otp_entry.email
        otp_entry.delete()

        return Response({"message": "OTP verified successfully"}, status=200)


class ResetPassword(APIView):
    def post(self, request):
        email = request.data.get("email")
        password = request.data.get("password")
        confirm_password = request.data.get("confirm_password")

        if not email or not password or not confirm_password:
            return Response({"error": "Email, password and confirm password are required"}, status=400)

        if password != confirm_password:
            return Response({"error": "Passwords do not match"}, status=400)

        try:
            user = User.objects.get(email=email)
            user.password = make_password(password)
            user.save()
            return Response({"message": "Password reset successful"}, status=200)
        except User.DoesNotExist:
            return Response({"error": "User not found"}, status=404)
# views.py
import os
import joblib
import pandas as pd
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from .models import PredictionResult
from .serializers import PredictionResultSerializer

# Paths
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
MODEL_PATH = os.path.join(BASE_DIR, 'breast_cancer_model.pkl')
ENCODERS_PATH = os.path.join(BASE_DIR, 'label_encoders.pkl')
TARGET_ENCODER_PATH = os.path.join(BASE_DIR, 'target_encoder.pkl')

# Load
model = joblib.load(MODEL_PATH)
label_encoders = joblib.load(ENCODERS_PATH)
target_encoder = joblib.load(TARGET_ENCODER_PATH)

# Manual risk level to percentage
RISK_PERCENTAGE_MAP = {
    "low": 25.0,
    "moderate": 60.0,
    "high": 90.0
}

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def predict_view(request):
    try:
        user = request.user
        mode = request.data.get('mode', 'symptoms')  # default to symptoms

        input_dict = {
            'age': int(request.data['age']),
            'menopausal_status': request.data['menopausal_status'],
            'family_history': request.data['family_history'],
            'bmi': request.data['bmi'],
            'menarche_age': int(request.data['menarche_age']),
            'breastfeeding_history': request.data['breastfeeding_history'],
            'alcohol_consumption': request.data['alcohol_consumption'],
            'hormonal_treatment_history': request.data['hormonal_treatment_history'],
            'physical_activity': request.data['physical_activity'],
            'breast_pain': request.data['breast_pain'],
            'breast_cancer': request.data['breast_cancer']
        }

        df = pd.DataFrame([input_dict])

        for col, le in label_encoders.items():
            df[col] = le.transform(df[col])

        prediction = model.predict(df)[0]
        risk_label = target_encoder.inverse_transform([prediction])[0]

        # Use manual map to get percentage
        prediction_percentage = RISK_PERCENTAGE_MAP.get(risk_label.lower(), 0)

        # Store in database
        result = PredictionResult.objects.create(
            user=user,
            risk_level=risk_label,
            prediction_percentage=prediction_percentage,
            mode=mode
        )

        serializer = PredictionResultSerializer(result)
        return Response(serializer.data)

    except Exception as e:
        return Response({'error': str(e)}, status=400)
    
import base64
import requests
import random
import re
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from .models import RiskAssessment
from .serializers import RiskAssessmentSerializer


class GeminiRiskView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        try:
            # Get uploaded image from request
            image_file = request.FILES.get('image')
            if not image_file:
                return Response({"error": "Image file is required"}, status=400)

            # Convert image to base64
            image_bytes = image_file.read()
            base64_image = base64.b64encode(image_bytes).decode('utf-8')

            # Call Gemini API
            url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyChyWtWrTKXlRhTx4yGJ84f3je3bJ2u6jw"
            headers = {"Content-Type": "application/json"}
            payload = {
                "contents": [{
                    "parts": [
                        {"text": "Based on this image, assess the breast cancer risk level (low, moderate, high)."},
                        {"inlineData": {
                            "mimeType": "image/png",
                            "data": base64_image
                        }}
                    ]
                }]
            }

            response = requests.post(url, headers=headers, json=payload)

            if response.status_code != 200:
                return Response({
                    "error": "Gemini API call failed",
                    "details": response.text
                }, status=400)

            result = response.json()
            text_result = result.get("candidates", [{}])[0].get("content", {}).get("parts", [{}])[0].get("text", "No output")

            # Extract risk level from response
            risk_match = re.search(r"\b(low|moderate|high)\b", text_result, re.IGNORECASE)
            risk_level = risk_match.group(1).capitalize() if risk_match else "Unknown"

            # Generate prediction percentage based on level
            if risk_level == "Low":
                percentage = round(random.uniform(10, 40), 2)
            elif risk_level == "Moderate":
                percentage = round(random.uniform(41, 70), 2)
            elif risk_level == "High":
                percentage = round(random.uniform(71, 100), 2)
            else:
                percentage = 0.0

            # Save result to database
            instance = RiskAssessment.objects.create(
                user=request.user,
                risk_level=risk_level,
                prediction_percentage=percentage,
                mode='image'
            )

            # Return serialized data
            serializer = RiskAssessmentSerializer(instance)
            return Response(serializer.data, status=200)

        except Exception as e:
            return Response({"error": str(e)}, status=500)
        
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
from .models import RiskAssessment, PredictionResult

class HistoryView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        user = request.user

        # Symptoms-based history
        symptoms_entries = PredictionResult.objects.filter(user=user)
        symptoms_data = [{
            'id': entry.id,
            'risk_level': entry.risk_level,
            'prediction_percentage': entry.prediction_percentage,
            'mode': entry.mode,
            'created_at': entry.created_at,
            'image': None
        } for entry in symptoms_entries]

        # Image-based history
        image_entries = RiskAssessment.objects.filter(user=user)
        image_data = []
        for entry in image_entries:
            image_url = None
            if hasattr(entry, 'image') and entry.image:
                image_url = request.build_absolute_uri(entry.image.url)

            image_data.append({
                'id': entry.id,
                'risk_level': entry.risk_level,
                'prediction_percentage': entry.prediction_percentage,
                'mode': entry.mode,
                'created_at': entry.created_at,
                'image': image_url
            })

        combined_data = symptoms_data + image_data
        combined_data.sort(key=lambda x: x['created_at'], reverse=True)

        return Response(combined_data)

    def post(self, request):
        """
        Creates a new history entry.
        Expected JSON:
        {
            "type": "symptoms" | "image",
            "risk_level": "High",
            "prediction_percentage": 85.5,
            "mode": "AI Model",
            "image": (optional if type='image')
        }
        """
        user = request.user
        entry_type = request.data.get("type")
        risk_level = request.data.get("risk_level")
        prediction_percentage = request.data.get("prediction_percentage")
        mode = request.data.get("mode")
        image = request.FILES.get("image")  # Only for image-based history

        if not all([entry_type, risk_level, prediction_percentage, mode]):
            return Response({"error": "Missing required fields"}, status=status.HTTP_400_BAD_REQUEST)

        if entry_type == "symptoms":
            entry = PredictionResult.objects.create(
                user=user,
                risk_level=risk_level,
                prediction_percentage=prediction_percentage,
                mode=mode
            )
            return Response({"message": "Symptoms history added", "id": entry.id}, status=status.HTTP_201_CREATED)

        elif entry_type == "image":
            if not image:
                return Response({"error": "Image file is required for image-based history"}, status=status.HTTP_400_BAD_REQUEST)

            entry = RiskAssessment.objects.create(
                user=user,
                risk_level=risk_level,
                prediction_percentage=prediction_percentage,
                mode=mode,
                image=image
            )
            return Response({"message": "Image history added", "id": entry.id}, status=status.HTTP_201_CREATED)

        else:
            return Response({"error": "Invalid type. Must be 'symptoms' or 'image'."}, status=status.HTTP_400_BAD_REQUEST)


import requests
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

class GeminiChatBotView(APIView):
    def post(self, request):
        try:
            prompt = request.data.get("prompt")

            if not prompt:
                return Response({"message": "How may I help you today?"}, status=200)

            # Gemini API call
            url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyAGzeq4SWeNfwNkg4qKYW7uWg4dFXhUY3g"
            headers = {"Content-Type": "application/json"}
            payload = {
                "contents": [
                    {
                        "parts": [
                            {"text": prompt}
                        ]
                    }
                ]
            }

            response = requests.post(url, headers=headers, json=payload)

            if response.status_code != 200:
                return Response({
                    "error": "Gemini API call failed",
                    "details": response.text
                }, status=status.HTTP_400_BAD_REQUEST)

            # Extract Gemini reply
            result = response.json()
            answer = result.get("candidates", [{}])[0].get("content", {}).get("parts", [{}])[0].get("text", "Sorry, no response.")

            return Response({"bot_reply": answer}, status=200)

        except Exception as e:
            return Response({"error": str(e)}, status=500)

import google.generativeai as genai
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

class GeminiChatBotView(APIView):
    def post(self, request):
        try:
            prompt = request.data.get("prompt", "").strip()

            if not prompt:
                return Response({"message": "Enter the prompt"}, status=400)

            # Configure Gemini API
            genai.configure(api_key="AIzaSyAGzeq4SWeNfwNkg4qKYW7uWg4dFXhUY3g")
            model = genai.GenerativeModel("gemini-pro")

            # Generate response
            response = model.generate_content(prompt)
            answer = response.text

            return Response({"bot_reply": answer}, status=200)

        except Exception as e:
            return Response({"error": str(e)}, status=500)

from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json

@csrf_exempt
def chatbot_api(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            message = data.get('message', '')

            # Dummy chatbot response logic
            if message.lower() == 'hello':
                reply = 'Hi there! How can I help you today?'
            elif message.lower() == 'bye':
                reply = 'Goodbye! Have a great day!'
            else:
                reply = f'You said: {message}'

            return JsonResponse({'response': reply})
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=400)
    else:
        return JsonResponse({'error': 'Invalid request method'}, status=405)

import requests
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json

GEMINI_API_KEY = "AIzaSyCI8L70_Hw2nilhIIws5F8kSgMKbZwwjMA"  # Your Gemini API key
GEMINI_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent"

@csrf_exempt
def chatbot_view(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)
            user_message = data.get("message", "")

            headers = {
                "Content-Type": "application/json",
                "X-goog-api-key": GEMINI_API_KEY
            }

            payload = {
                "contents": [
                    {
                        "parts": [
                            {
                                "text": user_message
                            }
                        ]
                    }
                ]
            }

            response = requests.post(GEMINI_URL, headers=headers, json=payload)
            result = response.json()

            # Extracting response
            reply = result["candidates"][0]["content"]["parts"][0]["text"] if "candidates" in result else "No response from AI."

            return JsonResponse({"response": reply})

        except Exception as e:
            return JsonResponse({"error": str(e)}, status=500)

    return JsonResponse({"error": "Invalid request method"}, status=400)


from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from .models import RiskAssessment
from .serializers import RiskAssessmentSerializer

class RiskAssessmentHistoryView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        """Get all history for the logged-in user"""
        history = RiskAssessment.objects.filter(user=request.user).order_by('-created_at')
        serializer = RiskAssessmentSerializer(history, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    def post(self, request):
        """Create new history entry"""
        data = request.data.copy()
        data['user'] = request.user.id  # assign logged-in user automatically
        serializer = RiskAssessmentSerializer(data=data)
        
        if serializer.is_valid():
            serializer.save(user=request.user)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
