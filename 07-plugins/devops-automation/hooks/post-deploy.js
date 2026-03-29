#!/usr/bin/env node

/**
 * Hook post-despliegue
 * Se ejecuta después de que el despliegue se completa
 */

async function postDeploy() {
  console.log('Ejecutando tareas post-despliegue...');

  const { execSync } = require('child_process');

  // Esperar a que los pods estén listos
  console.log('Esperando a que los pods estén listos...');
  try {
    execSync('kubectl wait --for=condition=ready pod -l app=myapp --timeout=300s', {
      stdio: 'inherit'
    });
  } catch (error) {
    console.error('❌ Los pods fallaron en estar listos');
    process.exit(1);
  }

  // Ejecutar smoke tests
  console.log('Ejecutando smoke tests...');
  // Agrega aquí tus comandos de smoke test

  console.log('✅ Tareas post-despliegue completadas');
}

postDeploy().catch(error => {
  console.error('El hook post-deploy falló:', error);
  process.exit(1);
});
