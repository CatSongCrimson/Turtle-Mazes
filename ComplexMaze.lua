--[[
Generate a complex maze without human interaction
First and last generation of a row must always be a '1' (solid block)
row 1 and final row as determined by code must have a 2 (start block) somewhere
along their length.
Rows must have at least one 0 (open block) that connects with 
a previous 0 in a past row.


make an array of every time 0 placed in last row
remove location from array after moving past it
Must place a 0 on the last array if it has not before.
2's count for this

array = {}

array[1] = "a"

print(table.concat(array)) -- prints "a"

array[#array + 1] = "b"

print(table.concat(array)) -- prints "ab"

pastArray = array

print(table.concat(pastArray)) -- prints "ab"


]]--
--possible variables:
--Turtle unique variables
local slot = 0
local current = 3
--task variables
local width = 0
local currentBlock = 1
local rowMax = 0
local currentRow = 1
local nowLocation = {}
local pastLocation = {}
local zeroPlaced = 0
local EntExit = 0
local component = 0
local nowArray = 1
local pastArray = 1
local enterBlock = 0
local finalOpen = 0
local Opening = 0
local isopen = false
--possible functions
local function checkslot()
    slot = turtle.getItemCount() -- Updates current stack size
    if slot <=width then -- IF the stack is less then or equal to width blocks
        current = current + 1 -- select the next stack
        turtle.select(current)
    end
end
local function opening()
    Opening = math.random(1,2)
end
local function entry()
    enterBlock = math.random(1,20)
end
local function turnaround()
    turtle.turnRight()
    turtle.turnRight()
end
local function arrayGenerate()
end
local function generate()
    width = math.random(5,10)
    rowMax = math.random(5,10)
end
local function rowGenerate()
    isopen = false
    nowLocation = pastLocation
    pastLocation = {}
    for i=1, width do
        if nowLocation[i] == 1 then
            opening()
            if isopen == false and currentBlock == finalOpen then
                turtle.forward()
                table.insert(pastLocation,currentBlock, 1)
                finalOpen = currentBlock
                currentBlock = currentBlock + 1
            else 
                if Opening == 1 then
                    turtle.placeDown()
                    turtle.forward()
                    table.insert(pastLocation,currentBlock, 0)
                    currentBlock = currentBlock + 1
                else
                    turtle.forward()
                    isopen = true
                    table.insert(pastLocation,currentBlock, 1)
                    finalOpen = currentBlock
                    currentBlock = currentBlock + 1
                end
            end
        if nowLocation[i] == 0 then
            opening()
            if Opening == 1 then
                turtle.placeDown()
                turtle.forward()
                table.insert(pastLocation,currentBlock, 0)
                currentBlock = currentBlock + 1
            else
                turtle.forward()
                table.insert(pastLocation,currentBlock, 1)
                finalOpen = currentBlock
                currentBlock = currentBlock + 1
                end
            end
            if currentBlock == width then
                turtle.placeDown()
                turtle.turnRight()
                turtle.forward()
                turtle.turnRight()                        
                for j = 1, width-1 do
                    turtle.forward()
                end
                currentBlock = 1
                turnaround()
                checkslot()
                if currentRow + 1 == rowMax then
                    EntExit = 0
                end
                currentRow = currentRow + 1
                end
        end
    end
end
local function firstRow()
    for i = 1, width do
        if currentRow == 1 or currentRow == rowMax then
                if EntExit == 0 then
                    entry()
                    if currentBlock + 1 == width then
                        turtle.select(2)
                        turtle.down()
                        turtle.digDown()
                        turtle.placeDown()
                        turtle.up()
                        turtle.forward()
                        turtle.select(current)
                        table.insert(pastLocation,currentBlock, 1)
                        finalOpen = currentBlock
                        currentBlock = currentBlock + 1
                        EntExit = EntExit + 1
                    else if enterBlock == 5 and currentBlock > 1 then
                        print(enterBlock)
                        turtle.select(2)
                        turtle.down()
                        turtle.digDown()
                        turtle.placeDown()
                        turtle.up()
                        turtle.forward()
                        turtle.select(current)
                        table.insert(pastLocation,currentBlock, 1)
                        finalOpen = currentBlock
                        currentBlock = currentBlock + 1
                        EntExit = EntExit + 1
                    end
            end
            end
    end
        if currentBlock == 1 or currentBlock == width or EntExit == 1 or EntExit == 0 then
            table.insert(pastLocation,currentBlock, 0)
            if currentBlock == 1 or currentBlock < width then
                turtle.placeDown()
                turtle.forward()
                currentBlock = currentBlock + 1
            end
            if currentBlock == width then
                turtle.placeDown()
                turtle.turnRight()
                turtle.forward()
                turtle.turnRight()
                for j = 1, width-1 do
                    turtle.forward()
                end
                currentBlock = 1
                turnaround()
                checkslot()
                currentRow = currentRow + 1
            end 
        end
    end
end

--possible complete code for generations--
turtle.select(1)
turtle.refuel()
turtle.select(current)
if width == 0 then
    generate()
end
--for k=1, rowMax do
print("First/Last row now!")
firstRow()
print("Generating Row!")
--rowGenerate()
checkslot()
print(table.concat(pastLocation, ", "))
--end