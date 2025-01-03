# Capacitor UAE Pass Plugin

A Capacitor plugin for integrating UAE Pass authentication into your mobile app. This plugin allows users to log in using their UAE Pass credentials and handles the authentication flow seamlessly.

---

## **Installation**

Follow these steps to install and configure the Capacitor UAE Pass Plugin in your project.

---

### **1. Install the dependencies**

Run the following commands to install the plugin and sync your Capacitor project:

```bash
npm install

Build the Plugin
Build the plugin to ensure everything is set up correctly:
npm run build

Install the Plugin in Your Project
Navigate to your project directory and install the plugin using the local path:

cd /path/to/your/project
npm install ../../ionic-login-uae-pass --legacy-peer-deps

Build the iOS Project
Build the iOS project to generate the necessary files. This step also automates the addition of the UAEPassClient pod to the Podfile.

npm run build:ios

What Happens During npm run build:ios?
The project is built.

The iOS platform is synced.

A post-build script automatically adds the UAEPassClient pod to the Podfile.

The pod install --repo-update command is run to install the pods.

Build the Xcode Project
Open the Xcode project and build it:
