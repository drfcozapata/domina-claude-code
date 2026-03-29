#!/usr/bin/env node

/**
 * Hook pre-revisión
 * Se ejecuta antes de iniciar la revisión de PR para asegurar que se cumplan los prerrequisitos
 */

async function preReview() {
  console.log('Ejecutando verificaciones pre-revisión...');

  // Verificar si es repositorio git
  const { execSync } = require('child_process');
  try {
    execSync('git rev-parse --git-dir', { stdio: 'pipe' });
  } catch (error) {
    console.error('❌ No es un repositorio git');
    process.exit(1);
  }

  // Verificar cambios no confirmados
  try {
    const status = execSync('git status --porcelain', { encoding: 'utf-8' });
    if (status.trim()) {
      console.warn('⚠️  Advertencia: Cambios no confirmados detectados');
    }
  } catch (error) {
    console.error('❌ Falló la verificación del estado de git');
    process.exit(1);
  }

  console.log('✅ Verificaciones pre-revisión completadas');
}

preReview().catch(error => {
  console.error('El hook pre-revisión falló:', error);
  process.exit(1);
});
