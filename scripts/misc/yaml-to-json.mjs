import fs from 'node:fs/promises'
import path from 'node:path'
import YAML from 'yaml'

async function yamlToJson(filePath) {
  const data = YAML.parse(await fs.readFile(filePath, 'utf8'))

  await fs.writeFile(
    filePath.replace(/\.ya?ml$/i, '.json'),
    JSON.stringify(data, null, 2),
  )

  return fs.rm(filePath)
}

export default async function convertAllYamlToJson(dirPath) {
  const yamlFiles = await Array.fromAsync(
    fs.glob(['**/*.{yaml,yml}', '**/.**/*.{yaml,yml}', '.**/**/*.{yaml,yml}'], {
      cwd: dirPath,
    }),
  )

  return Promise.all(
    yamlFiles.map((filePath) => yamlToJson(path.join(dirPath, filePath))),
  )
}
