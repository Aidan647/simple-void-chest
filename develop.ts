import { existsSync, statSync } from "node:fs"
import { readlink, unlink, symlink, mkdir } from "node:fs/promises"
import { resolve } from "node:path"
import { spawn } from "node:child_process"

const MOD_NAME = "simple-void-chest"
const DATA_DIR = resolve("./factorio-data")
const MODS_DIR = resolve(DATA_DIR, "mods")
const SRC_DIR = resolve("./src")
const MOD_LINK = resolve(MODS_DIR, MOD_NAME)

// --- Resolve Factorio binary ---

let factorioBin = process.argv[2]

if (!factorioBin) {
	console.error("Usage: bun run develop /path/to/factorio")
	console.error("")
	console.error("Provide the path to the Factorio binary or installation directory.")
	process.exit(1)
}

// If the path is a directory, assume it's the Factorio installation root
if (existsSync(factorioBin) && statSync(factorioBin).isDirectory()) {
	const candidate = resolve(factorioBin, "bin/x64/factorio")
	if (existsSync(candidate)) {
		factorioBin = candidate
	}
}

if (!existsSync(factorioBin)) {
	console.error(`Factorio binary not found at: ${factorioBin}`)
	process.exit(1)
}

console.log(`Factorio binary: ${factorioBin}`)

// --- Create directory structure ---

for (const dir of [DATA_DIR, MODS_DIR]) {
	if (!existsSync(dir)) {
		await mkdir(dir, { recursive: true })
	}
}

// --- Create / update symlink: mods/simple-void-chest -> src ---

if (existsSync(MOD_LINK)) {
	try {
		const existing = await readlink(MOD_LINK)
		if (existing !== SRC_DIR) {
			await unlink(MOD_LINK)
			await symlink(SRC_DIR, MOD_LINK)
			console.log(`Updated symlink: ${MOD_LINK} → ${SRC_DIR}`)
		} else {
			console.log(`Symlink already correct: ${MOD_LINK} → ${SRC_DIR}`)
		}
	} catch {
		// Not a symlink or broken — replace
		await unlink(MOD_LINK)
		await symlink(SRC_DIR, MOD_LINK)
		console.log(`Replaced symlink: ${MOD_LINK} → ${SRC_DIR}`)
	}
} else {
	await symlink(SRC_DIR, MOD_LINK)
	console.log(`Created symlink: ${MOD_LINK} → ${SRC_DIR}`)
}

// --- Launch Factorio ---

console.log(`\nLaunching Factorio...`)
console.log(`   --mod-directory=${MODS_DIR}\n`)

const proc = spawn(factorioBin, [
	`--mod-directory=${MODS_DIR}`,
	"--fullscreen=false",
], { stdio: "inherit" })

proc.on("exit", (code) => {
	console.log(`\nFactorio exited with code ${code}`)
})

process.on("SIGINT", () => {
	proc.kill("SIGINT")
})

process.on("SIGTERM", () => {
	proc.kill("SIGTERM")
})