# Libraries
When you use RoStrap, you are using tested and tried Libraries which are continually **maintained** by the best developers in town! Whenever a developer updates their Library on GitHub, you will see an update button appear (under the `INSTALLED` tab).

![](https://user-images.githubusercontent.com/15217173/38776955-f2ca9710-405c-11e8-86e9-74452dbd44ea.png)

Updates are detected when your source code doesn't match the source code of the latest version of GitHub, excluding whitespace, comments, and configurable variables. Configurable variables have to look like this:

```lua
local ALL_CAMEL_CASE = "SINGLE-LINE-VALUE"
```

# Contributing
If you wish to contribute a Library, simply submit a pull request to [Libraries.lua](https://github.com/RoStrap/Libraries/blob/master/Libraries.lua). Simply insert a new table with fields `URL` (you can leave off https://github.com) and an optional `Description` and you are good to go!

## Library Standards
Libraries contributed to RoStrap must be useful, reusable, and reasonably universal. The code must be stable, maintained, readable, and speedy. It must have a readme or documentation website that clearly outlines its use and includes functioning demo code. Images help.

Submitted Libraries may be subject to code review.

# Plugin
The following documentation outlines how the plugin works its magic.

## Library Discrimination
When the RoStrap plugin sees your `URL` within [Libraries.lua](https://github.com/RoStrap/Libraries/blob/master/Libraries.lua), it will figure out how many Libraries exist within the directory located at the `URL` (which can be a link to a single file). If Lua files are descendants of another Lua file, they will be considered a single Library. Find the definition of a Library [here](https://github.com/RoStrap/Resources#library).

To indicate to the plugin's installer that a Lua file is a descendant of another, simply make a folder with the name of the parent Lua file, and place the parent Lua file inside with the name "init" (or "main" or "\_"). Here is [an example of a single Library that has ModuleScripts within it.](https://github.com/evaera/EvLightning)

Folders containing multiple Lua files with names containing the name of a ancestor folder will also be considered a single installable-package by the plugin. Examples of this to come.

Libraries that should be installed and packaged differently from all of the already-integrated Libraries may require adjustment on the Plugin's part. In this case, do what makes the most sense for your GitHub repository or consider adding fields to the [Libraries table](https://github.com/RoStrap/Libraries/blob/master/Libraries.lua) and the installer will be adjusted.

## Dependencies
Dependencies are detected by the plugin using [this handy script](https://github.com/RoStrap/Libraries/blob/GetDeps/GetDependencies.ignore.lua). It can detect from the following source code that `Tween` and `Maid` are the names a Library will need to have installed in order to work. If your source code intends to rely on dependencies from the RoStrap system, [the detection script](https://github.com/RoStrap/Libraries/blob/GetDeps/GetDependencies.ignore.lua) *must* be able to successfully determine the dependencies of your Libraries.

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage") -- You have to use game:GetService
local Resources = require(ReplicatedStorage:WaitForChild("Resources")) -- You have to use WaitForChild
local require = Resources.LoadLibrary -- You can localize LoadLibrary

local Tween = require("Tween") -- Either of these work
local Maid = Resources:LoadLibrary('Maid')
```
