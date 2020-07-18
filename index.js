#!/usr/bin/env node
const glob = require('glob'),
  fs = require('fs'),
  path = require('path'),
  prettier = require('prettier'),
  keywords = JSON.parse(fs.readFileSync('./keywords.json'));

const getFiles = async () => new Promise((resolve, reject) => 
  glob(process.cwd() + '/**/*.ws', { ignore: process.cwd() + '/node_modules/**'}, (err, matches) => err && reject(err) || matches && resolve(matches)));

const getContent = (path) => new Promise((resolve, reject) => 
  fs.readFile(path, (err, data) => err && reject(err) || data && resolve(data)));

const transform = async (file) => ({ 
  path: path.join(process.cwd(), 'dist', file.replace(process.cwd(), '').replace(/\.ws$/, '.js')), 
  file: file.replace(process.cwd(), ''),
  content: String(await getContent(file)) 
});

const transpile = (file) => {
	Object.entries(keywords).map(([key, value]) => (file = { 
    ...file, 
    content: file.content.replace(new RegExp(key, 'g'), value) 
  }));
	return file;
};

const saveFile = (file) => new Promise((resolve, reject) => {
  fs.mkdir(file.path.substring(0, file.path.lastIndexOf(path.sep)), { recursive: true }, (err) => {
    if (err) return reject(err);
    console.info(`[WienerScript] DRAH DI DEPPATA ${file.file} ==> ${file.path.replace(process.cwd(), '')}`);
    fs.writeFile(file.path, prettier.format(file.content, { parser: 'babel' }), (err, data) => err && reject(err) || data && resolve(data));
  });
});

(async () => {
  try {
    const files = (await getFiles()).map(path.normalize);
    console.info(`[WienerScript] HAWIDERE! DO HOBN MA ${files.length} GSCHICHTLN!`);
    (await Promise.all(files.map(transform))).map(transpile).map(saveFile);
  } catch(err) {
    console.error('[WienerScript] DO IS WOS SCHIEF GRENNT:');
    throw err;
  }
})();