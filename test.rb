require_relative 'utils/loader'

@script = load_script('./solution.rb')

@tests = [0,0,0] # total, passed, failed

def runTest houses, elves, expected
  result = @script[:callable].call(elves,houses)
  test_result = result == expected ? "✅" : "⚠️"
  @tests[0] += 1
  @tests[result == expected ? 1 : 2] += 1
  puts "#{test_result} '#{houses}', #{elves} elves => #{result}"
end

def final_report
  puts "\n#{@tests[0]} tests, #{@tests[1]} passed, #{@tests[2]} failed"
  puts "Script size: #{@script[:size] - 1}"
end

runTest("1*1", 5, 5)
runTest("1*1", 3, 9)
runTest("1*2", 7, 5)
runTest("1*2", 5, 8)
runTest("1*2", 3, 13)
runTest("2*1", 8, 5)
runTest("2*1", 5, 10)
runTest("2*1", 3, 14)
runTest("1*", 3, 5)
runTest("1*", 2, -1)
runTest("*1", 2, 4)
runTest("*1", 0, -1)
runTest("*", 0, 0)
runTest("1*1+1*1", 5, 10)
runTest("1*1+1*1", 3, 18)
runTest("1*1+*+1*1", 3, 18)
runTest("1*2+2*1", 8, 10)
runTest("1*2+2*1", 7, 14)
runTest("1*2+2*1", 6, 17)
runTest("1*2+2*1", 3, 27)
runTest("1*2+2*1", 2, -1)
runTest("*+*+*+*", 2, 0)
runTest("*+*+*+*", 0, 0)
runTest("*+5*3+*+*", 0, -1)
# runTest("1*3+2*+*5+*+4*7", 9, 32)
# runTest("4*14", 9, 20)

final_report