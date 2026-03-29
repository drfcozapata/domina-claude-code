#!/usr/bin/env node

/**
 * Hook pre-despliegue
 * Valida el entorno y prerrequisitos antes del despliegue
 */

async function preDeploy() {
  console.log('Ejecutando verificaciones pre-despliegue...');

  const { execSync } = require('child_process');

  // Verificar si kubectl está instalado
  try {
    execSync('which kubectl', { stdio: 'pipe' });
  } catch (error) {
    console.error('❌ kubectl no encontrado. Por favor instala Kubernetes CLI.');
    process.exit(1);
  }

  // Verificar si está conectado al cluster
  try {
    execSync('kubectl cluster-info', { stdio: 'pipe' });
  } catch (error) {
    console.error('❌ No conectado al cluster de Kubernetes');
    process.exit(1);
  }

  console.log('✅ Verificaciones pre-despliegue completadas');
}

preDeploy().catch(error => {
  console.error('El hook pre-deploy falló:', error);
  process.exit(1);
});
