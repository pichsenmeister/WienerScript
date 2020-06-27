#!/usr/bin/env node

const glob = require('glob')
const fs = require('fs')
const path = require('path')
const mkdirp = require('mkdirp')
const prettier = require('prettier')

// options is optional
const getFiles = () => {
    return glob.sync("**/*.ws")
}

const compile = (content) => {
    const keywords = JSON.parse(fs.readFileSync('keywords.json', 'utf8'))
    for (const key in keywords) {
        content = content.replace(new RegExp(key, "g"), keywords[key]);
    }
    return content
}

const run = () => {
    const files = getFiles()
    files.forEach(file => {
        const content = fs.readFileSync(path.normalize(path.join(__dirname, file)), 'utf8')
        const dir = path.join(__dirname, 'dist')
        if (!fs.existsSync(dir)) fs.mkdirSync(dir)

        const dirs = file.substring(0, file.lastIndexOf(path.sep))
        mkdirp.sync(path.join(__dirname, 'dist', dirs))

        const filePath = path.join(__dirname, 'dist', file.replace('.ws', '.js'))
        fs.writeFileSync(filePath, prettier.format(compile(content), { parser: 'babel' }), (error) => console.error(error))
    })
}

run()