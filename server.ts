import express from 'express';
import { createServer as createViteServer } from 'vite';
import authRoutes from './src/server/routes/auth';
import craftsmenRoutes from './src/server/routes/craftsmen';
import adminRoutes from './src/server/routes/admin';
import verificationRoutes from './src/server/routes/verification';

async function startServer() {
  const app = express();
  const PORT = 3000;

  app.use(express.json());

  // API Routes
  app.use('/api/auth', authRoutes);
  app.use('/api/craftsmen', craftsmenRoutes);
  app.use('/api/admin', adminRoutes);
  app.use('/api/verification', verificationRoutes);

  // Vite middleware for development
  if (process.env.NODE_ENV !== 'production') {
    const vite = await createViteServer({
      server: { middlewareMode: true },
      appType: 'spa',
    });
    app.use(vite.middlewares);
  } else {
    app.use(express.static('dist'));
  }

  app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server running on http://localhost:${PORT}`);
  });
}

startServer();
