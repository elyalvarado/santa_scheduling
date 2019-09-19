def santa_time elves, serialized_houses
  houses = serialized_houses.split /\+|\n/
  houses.map { |house|
    naughty_people, good_people = house.split('*').map(&:to_i)
    good_people ||= 0
    naughty_people ||= 0
    return -1 if (good_people > 0 && elves < 2) ||(naughty_people > 0 && elves < 3)
    next 0 if elves == 0
    all_jobs = [1]*naughty_people + [0]*good_people
    all_possible_order_of_jobs = all_jobs.permutation
    finish_times = all_possible_order_of_jobs.map do |job_list|
      jobs = job_list.map { |x| x==1 ? [3,5] : [2,4] }
      current_height = [0] * elves
      jobs.each do |package|
        package_width, package_height = package
        spaces_available_to_the_right = current_height.map.with_index do |x,i|
          a = 0
          current_height[i..elves].each { |r| r <= x ? a+=1 : break }
          a
        end
        spaces_available_to_the_left = current_height.map.with_index do |x,i|
          a = 0
          current_height[0..i].reverse.each { |r| r <= x ? a+=1 : break }
          a
        end
        all_columns_with_space_available_to_the_right =
            spaces_available_to_the_right.each.with_index.inject([]) { |acc,(x,i)|
              acc<<i if x >= package_width
              acc
            }
        column_with_spaces_available_to_the_right_and_min_height =
            all_columns_with_space_available_to_the_right.min { |a,b|
              current_height[a] <=> current_height[b]
            }
        bottom_left_column =
            column_with_spaces_available_to_the_right_and_min_height -
                (spaces_available_to_the_left[
                    column_with_spaces_available_to_the_right_and_min_height
                ] - 1)
        new_height_for_affected_columns = current_height[
            column_with_spaces_available_to_the_right_and_min_height
        ] + package_height
        (bottom_left_column..(bottom_left_column+package_width-1)).each { |x|
          current_height[x] = new_height_for_affected_columns
        }
      end
      current_height.max
    end
    finish_times.min
  }.sum
end
