/// <reference types="vitest" />
import { defineConfig } from 'vite';
import type { UserConfig as VitestUserConfigInterface } from 'vitest/config';
import react from '@vitejs/plugin-react'

const vitestConfig: VitestUserConfigInterface = {
  test: {
    deps: {
      inline: [/@just-web/, /just-web-react/]
    },
    setupFiles: ['src/setupTest.ts'],
    environment: 'jsdom',
  }
};

// https://vitejs.dev/config/
export default defineConfig({
  test: vitestConfig.test,
  plugins: [react()],
  server: {
    proxy: {
      // string shorthand: http://localhost:5173/auth -> http://localhost:4000/auth
      '/auth': 'http://localhost:4000',
      // string shorthand: http://localhost:5173/v1 -> http://localhost:4000/v1
      '/v1': 'http://localhost:4000',
    },
  },
});
