import pandas as pd
import joblib
from sklearn.preprocessing import LabelEncoder
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split

# Load your dataset
df = pd.read_csv('medi/dataset/breast_cancer_dataset_with_prediction.csv')

# Automatically generate 'risk_level'
def compute_risk(row):
    if row['breast_cancer'] == 'yes':
        if row['family_history'] == 'yes' or row['bmi'] in ['overweight', 'high']:
            return 'High'
        return 'Medium'
    return 'Low'

df['risk_level'] = df.apply(compute_risk, axis=1)

# Define features and label
features = [
    'age', 'menopausal_status', 'family_history', 'bmi', 'menarche_age',
    'breastfeeding_history', 'alcohol_consumption', 'hormonal_treatment_history',
    'physical_activity', 'breast_pain', 'breast_cancer'
]

X = df[features]
y = df['risk_level']

# Label encode categorical features
categorical_cols = X.select_dtypes(include='object').columns
label_encoders = {}

for col in categorical_cols:
    le = LabelEncoder()
    X[col] = le.fit_transform(X[col])
    label_encoders[col] = le

# Encode target
target_encoder = LabelEncoder()
y = target_encoder.fit_transform(y)

# Save target encoder
joblib.dump(target_encoder, 'medi/target_encoder.pkl')

# Split and train
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
model = RandomForestClassifier()
model.fit(X_train, y_train)

# Save model and encoders
joblib.dump(model, 'medi/breast_cancer_model.pkl')
joblib.dump(label_encoders, 'medi/label_encoders.pkl')

print("✅ Model trained and risk levels saved successfully.")