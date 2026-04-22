# Product Recognition ML App

This repository contains a Flutter app for product recognition, along with the dataset, training scripts, and exported model assets used by the project.

## Repository Layout

- `app/` - Flutter application source code
- `dataset/` - Image and label data used for model training and evaluation
- `scripts/` - Utility scripts for dataset preparation and annotation
- `training/` - Model training and export code

## Flutter App

The main app lives in `app/`. See `app/README.md` for the default Flutter project notes.

## Data And Model Files

- `app/assets/models/product_detection.tflite` - TensorFlow Lite model used by the app
- `app/assets/models/labels.txt` - Class labels for the model

## Notes

This project is organized as a local ML workflow: prepare data, train or export the model, and run the Flutter app against the generated artifacts.
