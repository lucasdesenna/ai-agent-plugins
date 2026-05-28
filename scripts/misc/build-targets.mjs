import fs from 'node:fs/promises'
import path from 'node:path'
import { readInstructions, executeInstruction } from './instructions.mjs'

async function readTargets(targetsDir) {
  const targetsFilenames = await Array.fromAsync(
    fs.glob('*.{yaml,yml}', { cwd: targetsDir }),
  )

  return Promise.all(
    targetsFilenames.map((filename) =>
      readInstructions(path.resolve(targetsDir, filename)),
    ),
  )
}

async function buildTarget(srcDir, distDir, target) {
  return Promise.all(
    target.map((instruction) =>
      executeInstruction(srcDir, distDir, instruction),
    ),
  )
}

export default async function buildAllTargets(srcDir, targetsDir, distDir) {
  for (const target of await readTargets(targetsDir)) {
    await buildTarget(srcDir, distDir, target)
  }
}
