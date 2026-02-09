import pandas as pd
import numpy as np
import uuid

# Goal: Create a dataset for regulatory compliance testing
def generate_regulatory_data(rows=1000):
    data = {
        'transaction_id': [str(uuid.uuid4()) for _ in range(rows)],
        'customer_id': np.random.randint(1000, 9999, size=rows),
        'amount': np.random.uniform(10.0, 5000.0, size=rows).round(2),
        'timestamp': pd.date_range(start='2024-01-01', periods=rows, freq='h'),
        'status': np.random.choice(['Success', 'Pending', 'Flagged', None], size=rows, p=[0.8, 0.1, 0.05, 0.05])
    }
    
    df = pd.DataFrame(data)
    # Introducing "dirty data" to show off validation skills
    df.iloc[0:10, 2] = np.nan  # Missing amounts
    df.to_csv('raw_regulatory_data.csv', index=False)
    print("✅ synthetic dataset 'raw_regulatory_data.csv' created.")

if __name__ == "__main__":
    generate_regulatory_data()
