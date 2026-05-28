#!/usr/bin/env node

import fs from 'node:fs/promises'
import path from 'node:path'
import buildAllTargets from './misc/build-targets.mjs'
import convertAllYamlToJson from './misc/yaml-to-json.mjs'

const env = {
  srcDir: path.resolve(process.env.SRC_DIR),
  targetsDir: path.resolve(process.env.TARGETS_DIR),
  distDir: path.resolve(process.env.DIST_DIR),
}

async function cleanDist(distDir) {
  await fs.rm(distDir, { recursive: true, force: true })
  return fs.mkdir(distDir, { recursive: true })
}

async function main() {
  try {
    const { srcDir, targetsDir, distDir } = env

    await cleanDist(distDir)
    await buildAllTargets(srcDir, targetsDir, distDir)
    await convertAllYamlToJson(distDir)

    process.exit(0)
  } catch (error) {
    console.error(error instanceof Error ? error.message : error)
    process.exit(1)
  }
}

main()
