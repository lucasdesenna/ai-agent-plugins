import fs from 'node:fs/promises'
import path from 'node:path'
import YAML from 'yaml'

function adaptInstruction([from, to]) {
  return [from, to || path.basename(from)]
}

export async function readInstructions(path) {
  const file = YAML.parse(await fs.readFile(path, 'utf8'))

  return Object.entries(file).map(adaptInstruction)
}

export async function executeInstruction(srcDir, distDir, [from, to]) {
  const fromPaths = await Array.fromAsync(fs.glob(path.join(srcDir, from)))
  const executions = fromPaths.map((fromPath) => {
    const toPath = path.join(
      distDir,
      path.relative(srcDir, path.dirname(fromPath)),
      to,
    )

    return fs.cp(fromPath, toPath, { recursive: true })
  })

  return Promise.all(executions)
}
