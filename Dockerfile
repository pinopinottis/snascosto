FROM python:3.11-slim-bullseye

# Set working directory
WORKDIR /app

# Install system dependencies (optional but useful for some libs)
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
  && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app
COPY . .

# The app will listen on port 7860
EXPOSE 7860

# Run the FastAPI app (main_app is defined in run.py)
CMD ["uvicorn", "run:main_app", "--host", "0.0.0.0", "--port", "7860", "--workers", "4"]
