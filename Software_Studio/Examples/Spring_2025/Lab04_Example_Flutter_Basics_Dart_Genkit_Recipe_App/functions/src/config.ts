import { genkit } from 'genkit';
import { vertexAI } from '@genkit-ai/vertexai';


const firebaseConfig = {
  // Todo: add your config here
  
};

export const getProjectId = () => firebaseConfig.projectId;

export const ai = genkit({
  plugins: [
    vertexAI({
      projectId: getProjectId(),
      location: 'us-central1',
      // models: 
    }),
  ],
});


