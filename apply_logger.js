const fs = require('fs');
const path = require('path');

const dirsToScan = [
    'src/main/java/com/vistaluxhms/controller',
    'src/main/java/com/vistaluxhms/services',
    'src/main/java/com/vistaluxevent/controller',
    'src/main/java/com/vistaluxevent/services',
    'src/main/java/com/vistaluxhms/util'
];

function scanDir(dir, fileList = []) {
    const files = fs.readdirSync(dir);
    for (const file of files) {
        const fullPath = path.join(dir, file);
        if (fs.statSync(fullPath).isDirectory()) {
            scanDir(fullPath, fileList);
        } else if (fullPath.endsWith('.java')) {
            fileList.push(fullPath);
        }
    }
    return fileList;
}

function processJavaFile(filePath) {
    let content = fs.readFileSync(filePath, 'utf-8');
    
    // Ignore interfaces or enums broadly if no class definition is found
    const classMatch = content.match(/public class (\w+)/);
    if (!classMatch) return;
    const className = classMatch[1];

    let modified = false;

    // Check if slf4j is imported
    if (!content.includes('import org.slf4j.Logger;')) {
        content = content.replace(/(package .*?;)/, '$1\n\nimport org.slf4j.Logger;\nimport org.slf4j.LoggerFactory;');
        modified = true;
    }

    // Check if logger is initialized
    if (!content.includes('LoggerFactory.getLogger')) {
        const loggerStatement = `    private static final Logger logger = LoggerFactory.getLogger(${className}.class);\n`;
        // Find public class Start
        content = content.replace(/(public class \w+(?:\s+extends\s+\w+)?(?:\s+implements\s+[\w\s,]+)?\s*\{(?:\s*\n)?)/, `$1\n${loggerStatement}`);
        modified = true;
    }

    // Replace System.out.println
    const sysoutRegex = /System\.out\.println\(([^)]*)\);/g;
    if (sysoutRegex.test(content)) {
        content = content.replace(sysoutRegex, 'logger.debug($1);');
        modified = true;
    }

    // Replace <ex>.printStackTrace();
    const stackTraceRegex = /([a-zA-Z0-9_]+)\.printStackTrace\(\);/g;
    if (stackTraceRegex.test(content)) {
        content = content.replace(stackTraceRegex, 'logger.error("Exception caught", $1);');
        modified = true;
    }

    if (modified) {
        fs.writeFileSync(filePath, content, 'utf-8');
        console.log(`Updated: ${filePath}`);
    }
}

let allFiles = [];
for (const dir of dirsToScan) {
    if (fs.existsSync(dir)) {
        allFiles = allFiles.concat(scanDir(dir));
    }
}

for (const file of allFiles) {
    processJavaFile(file);
}
console.log('Logger setup completed.');
