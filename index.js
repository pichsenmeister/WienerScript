#!/usr/bin/env node

const glob = require('glob')
const fs = require('fs')
const path = require('path')
const mkdirp = require('mkdirp')
const prettier = require('prettier')

// options is optional
const getFiles = (currentPath) => {
    const files = glob.sync(currentPath + "/**/*.ws")
    return files.filter(file => file.indexOf('node_modules/') < 0)
}

const compile = (content) => {
    const keywords = JSON.parse(fs.readFileSync(path.join(__dirname, 'keywords.json'), 'utf8'))
    for (const key in keywords) {
        content = content.replace(new RegExp(key, "g"), keywords[key]);
    }
    return content
}

const run = () => {
    console.log('HAWIDERE')
    const currentPath = process.cwd()
    const files = getFiles(currentPath)

    console.log('DO HOBN MA ' + files.length + ' GSCHICHTLN')

    files.forEach(file => {
        const content = fs.readFileSync(path.normalize(file), 'utf8')
        const dir = path.join(currentPath, 'dist')
        if (!fs.existsSync(dir)) fs.mkdirSync(dir)

        const dirs = file.substring(0, file.lastIndexOf(path.sep)).replace(currentPath, '')
        mkdirp.sync(path.join(currentPath, 'dist', dirs))

        const filePath = path.join(currentPath, 'dist', file.replace(currentPath, '').replace('.ws', '.js'))
        console.log('DRAH DI DEPATTA', file.replace(currentPath, '').replace(path.sep, '') + ' ==> ' + filePath.replace(currentPath, '').replace(path.sep, ''))
        fs.writeFileSync(filePath, prettier.format(compile(content), { parser: 'babel' }), (error) => console.error(error))
    })

    console.log('PFIATI')
}

run()