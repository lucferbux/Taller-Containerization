import React from 'react';
import ReactDOM from 'react-dom/client';
import './i18n';
import * as Sentry from '@sentry/react';
import { BrowserTracing } from '@sentry/tracing';
import App from './components/App';
import { AuthProvider } from './context/AuthContext';
import './main.css';
import { HelmetProvider } from 'react-helmet-async';
import { ProjectProvider } from './context/ProjectContext';

Sentry.init({
  dsn: import.meta.env.VITE_SENTRY_API,
  integrations: [new BrowserTracing()],

  // Set tracesSampleRate to 1.0 to capture 100%
  // of transactions for performance monitoring.
  // We recommend adjusting this value in production
  tracesSampleRate: 1.0
});

const root = ReactDOM.createRoot(document.getElementById('root') as HTMLElement);

root.render(
  <React.StrictMode>
    <HelmetProvider>
      <AuthProvider>
        <ProjectProvider>
          <App />
        </ProjectProvider>
      </AuthProvider>
    </HelmetProvider>
  </React.StrictMode>
);
