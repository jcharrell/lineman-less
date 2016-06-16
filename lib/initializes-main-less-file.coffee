fs = require('fs')
path = require('path')
appRoot = require('app-root-path').toString()

module.exports =
  initialize: (dir = process.cwd()) ->
    topDir = appRoot
    return unless isInstalledAsDependency(dir, topDir)
    ensureMainLessFileExistsRelativeTo(topDir)


isInstalledAsDependency = (dir, topDir) ->
  topDir? && topDir != dir

ensureMainLessFileExistsRelativeTo = (dir) ->
  mainLessPath = path.join(dir, "app/css/main.less")
  return if fs.existsSync(mainLessPath)
  fs.writeFileSync mainLessPath,  """
    // Main less file for your application.
    // Use `@import` to use other less files
    // relative to 'app/css' or 'vendor/css'.

    """
  console.log """
    Thank you for installing lineman-less!

    We've added a main less file for you to help you get started, here:

    #{mainLessPath}

    """

