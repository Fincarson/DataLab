import { genkit } from 'genkit';
import { vertexAI } from '@genkit-ai/vertexai';

const firebaseConfig = {
  // TODO: add your firebase config here
  apiKey: "AIzaSyBUtqrFruNn3lAJqTufqRxLrvQP29unXW4",
  authDomain: "genkit-recipe-app-1c0c4.firebaseapp.com",
  projectId: "genkit-recipe-app-1c0c4",
  storageBucket: "genkit-recipe-app-1c0c4.firebasestorage.app",
  messagingSenderId: "656962538249",
  appId: "1:656962538249:web:410a928d32d57691d3a1d8"
};

export const getProjectId = () => firebaseConfig.projectId;

// enableFirebaseTelemetry({ projectId: getProjectId() });

export const ai = genkit({
  plugins: [
    vertexAI({
      projectId: getProjectId(),
      location: 'us-central1',
    }),
  ],
});
