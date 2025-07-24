from django.urls import path
from .views import MedicalImage
from .views import RegisterView,EmailLoginView,ProfileView,SymptomsView,MedicalImageUploadView,MedicalImageDeleteView,ChangePasswordView,DeleteAccountView

urlpatterns=[
    path('register/', RegisterView.as_view(), name='register'),
    path('login/', EmailLoginView.as_view(), name='email_login'),
    path('api/profile/', ProfileView.as_view(), name='profile'),
    path('api/symptoms/', SymptomsView.as_view(), name='symptoms'),
    path('api/upload-medical-image/', MedicalImageUploadView.as_view(), name='upload-medical-image'),
    path('api/medical-image/<int:pk>/', MedicalImageDeleteView.as_view(), name='delete-medical-image'),
    path('api/change-password/', ChangePasswordView.as_view(), name='change-password'),
    path('api/delete-account/', DeleteAccountView.as_view(), name='delete-account'),

]