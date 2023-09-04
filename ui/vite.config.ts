/// <reference types="vitest" />
import { defineConfig, loadEnv } from 'vite';
import type { UserConfig as VitestUserConfigInterface } from 'vitest/config';
import react from '@vitejs/plugin-react';

const vitestConfig: VitestUserConfigInterface = {
  test: {
    deps: {
      inline: [/@just-web/, /just-web-react/]
    },
    setupFiles: ['src/setupTest.ts'],
    environment: 'jsdom',
    exclude: [
      '**/node_modules/**',
      '**/dist/**',
      '**/cypress/**',
      '**/.{idea,git,cache,output,temp}/**',
      './src/__tests__/e2e/**'
    ]
  }
};

export default ({ mode }) => {
  process.env = { ...process.env, ...loadEnv(mode, process.cwd()) };

  return defineConfig({
    test: vitestConfig.test,
    plugins: [react()],
    server: {
      proxy: {
        // string shorthand: http://localhost:5173/auth -> http://localhost:4000/auth
        '/auth': process.env.VITE_PROXY_HOST,
        // string shorthand: http://localhost:5173/v1 -> http://localhost:4000/v1
        '/v1': process.env.VITE_PROXY_HOST
      }
    }
  });
};
