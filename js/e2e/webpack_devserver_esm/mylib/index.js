import packageJson from './package.json'
import chalk from 'chalk'
export function name() {
    return chalk.green(packageJson.name)
}
