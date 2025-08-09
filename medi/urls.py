from django.urls import path
from django.urls import path
from . import views
from .views import MedicalImage
#from .views import RegisterView,EmailLoginView,views,SymptomsView,MedicalImageUploadView,MedicalImageDeleteView,ChangePasswordView,DeleteAccountView,RequestPasswordResetOTP,VerifyOTPAPIView,ResetPassword,predict_view,GeminiRiskView,HistoryView,GeminiChatBotView,GeminiChatBotView,chatbot_api,chatbot_view,RiskAssessmentHistoryView
from .views import RegisterView, EmailLoginView, SymptomsView, MedicalImageUploadView, MedicalImageDeleteView, ChangePasswordView, DeleteAccountView, RequestPasswordResetOTP, VerifyOTPAPIView, ResetPassword, predict_view, GeminiRiskView, HistoryView, GeminiChatBotView, chatbot_api, chatbot_view, RiskAssessmentHistoryView

urlpatterns=[
    path('register/', RegisterView.as_view(), name='register'),
    path('login/', EmailLoginView.as_view(), name='email_login'),
     path('data/create/', views.create_user_data, name='create_user_data'),
    path('data/update/', views.update_user_data, name='update_user_data'),
    path('data/', views.get_user_data, name='get_user_data'),
    path('api/symptoms/', SymptomsView.as_view(), name='symptoms'),
    path('api/upload-medical-image/', MedicalImageUploadView.as_view(), name='upload-medical-image'),
    path('api/medical-image/<int:pk>/', MedicalImageDeleteView.as_view(), name='delete-medical-image'),
    path('api/change-password/', ChangePasswordView.as_view(), name='change-password'),
    path('api/delete-account/', DeleteAccountView.as_view(), name='delete-account'),
    path('request-otp/', RequestPasswordResetOTP.as_view(), name='request-otp'),
    path('verify-otp/', VerifyOTPAPIView.as_view(), name='verify-otp'),
    path('reset-password/', ResetPassword.as_view(), name='reset-password'),
    path('predict/', predict_view, name='predict'),
    path('api/gemini-risk/', GeminiRiskView.as_view(), name='gemini-risk'),
    path('api/risk-history/', HistoryView.as_view(), name='risk-history'),
    path('api/chatbot/', GeminiChatBotView.as_view(), name='chatbot'),
    path("chatbot/", GeminiChatBotView.as_view(), name="chatbot"),
    path('api/chatbot_uday/', chatbot_api, name='chatbot_api'),
    path('api/chatbot_udaykumar/', chatbot_view, name='chatbot'),
     path('history/', RiskAssessmentHistoryView.as_view(), name='risk-history'),
]