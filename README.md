# 🧠 Deepfake Detection Using Deep Learning (Django + ResNeXt + LSTM)

A full-stack deepfake detection system powered by PyTorch, ResNeXt, and LSTM, wrapped in a Django web application with optional Docker deployment. It classifies uploaded videos as **real** or **fake** using a sequence of extracted face frames.

---

## 📌 Features

- 🔍 Detects deepfakes from video or image input
- 📦 Sequence modeling using **CNN + LSTM**
- ⚡ ResNeXt-50 as backbone for feature extraction
- 🎯 Works on 10/20/30-frame models (customizable)
- 🌐 Django web interface
- 🐳 Dockerized for GPU deployment
- 🎥 Real-time heatmap and face detection visualization

---

## 📁 Directory Structure

```
Deepfake_Detection/
│
├── ml_app/                  # Core logic, views, model interface
├── project_settings/        # Django settings & URLs
├── static/                  # JS, CSS, face-api models
├── templates/               # HTML templates (Bootstrap)
├── uploaded_videos/         # Runtime video uploads
├── uploaded_images/         # Extracted face images
├── models/                  # Pretrained PyTorch models (.pt)
├── requirements.txt
└── manage.py
```

---

## 🧠 Model Architecture

### 🧬 CNN (ResNeXt-50)
We use **ResNeXt-50 (32x4d)** pretrained on ImageNet for high-performance frame-level feature extraction.

### 🕸️ LSTM
A two-layer bidirectional **LSTM** learns temporal patterns from sequences of facial features across video frames. The final hidden state is used for classification.

### 🔍 Classifier
- Dense layer + dropout + sigmoid for binary classification
- Output: **Real (0)** or **Fake (1)**

---

## 🧪 Dataset

We trained the model on the **DFDC dataset** (Deepfake Detection Challenge), using extracted face crops via MTCNN and saved into frame sequences for each video.

---

## 🚀 Installation & Local Setup

### 1️⃣ Clone the repository
```bash
git clone https://github.com/vaibhavjha01/deepfake-detector.git
cd deepfake-detector
```

### 2️⃣ Create and activate virtual environment (optional)
```bash
python -m venv venv
source venv/bin/activate  # on Windows: venv\Scripts\activate
```

### 3️⃣ Install dependencies
```bash
pip install -r requirements.txt
```

### 4️⃣ Download and place model
Download pretrained `.pt` model from [Google Drive](https://drive.google.com/drive/folders/1UX8jXUXyEjhLLZ38tcgOwGsZ6XFSLDJ-?usp=sharing)  
Place it in the `models/` folder (e.g., `model_84_acc_10_frames_final_data.pt`)

⚠️ **Model filename format is important**:  
`model_<accuracy>_acc_<num_frames>_frames_final_data.pt`

### 5️⃣ Create required folders
```bash
mkdir models uploaded_videos uploaded_images
```

### 6️⃣ Run the Django server
```bash
python manage.py runserver
```

---

## 🐳 Docker Deployment (GPU Recommended)

### 🔧 Prerequisites
- NVIDIA GPU
- CUDA >= 10.0
- Docker with NVIDIA Container Toolkit

### 🚀 Run Deepfake Detection Container
```bash
docker run --rm --gpus all   -v static_volume:/home/app/staticfiles/   -v media_volume:/app/uploaded_videos/   --name=deepfake_app   your-dockerhub-username/deepfake-detector
```

### 🌐 Run Nginx Reverse Proxy
```bash
docker run -p 80:80 --volumes-from deepfake_app   -v static_volume:/home/app/staticfiles/   -v media_volume:/app/uploaded_videos/   your-dockerhub-username/deepfake-nginx
```

Visit [http://localhost:80](http://localhost:80) to use the app.

---

## 🖼️ Demo Screenshot

<p align="center">
  <img src="https://github.com/Vaibhav06Jha28/deepfake-detector/blob/main/static/images/demo.png" width="80%" />
</p>

---


---

## 📦 Tech Stack

| Layer         | Tech                                 |
|---------------|--------------------------------------|
| Backend       | Python, Django                       |
| Deep Learning | PyTorch, ResNeXt-50, LSTM            |
| Frontend      | HTML, Bootstrap, JS, face-api.js     |
| Deployment    | Docker, Nginx, NVIDIA CUDA           |

---

## ✨ Future Improvements

- 🔁 Real-time video streaming support
- 🤖 Training interface with custom datasets
- 🧊 Replace LSTM with Transformer for temporal learning
- ☁️ Cloud inference API (AWS / GCP)

---

## 🧑‍💻 Developed By

**Vaibhav Jha**  
Connect with me on [https://www.linkedin.com/in/vaibhav-jha-27191b1ba/ ]| Star this repo ⭐ if it helped you!

---


## 📄 License

This project is licensed under the [MIT License](LICENSE).
