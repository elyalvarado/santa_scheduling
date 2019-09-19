def santa_time elves, serialized_houses
  # We parse the houses spliting on + or newline
  houses = serialized_houses.split /\+|\n/

  # Iterating over the houses
  houses.map { |house|
    # For each house get how many naughty and how many good people there is
    naughty_people, good_people = house.split('*').map(&:to_i)

    # It could also be 0 if not specified
    good_people ||= 0
    naughty_people ||= 0

    # Check that there are enough elves to solve the problem
    return -1 if (good_people > 0 && elves < 2) ||(naughty_people > 0 && elves < 3)

    # If here there are no elves, then obviously the time is 0
    next 0 if elves == 0

    # Create the all jobs array
    all_jobs = [1]*naughty_people + [0]*good_people

    # Then try all possible permutations
    all_possible_order_of_jobs = all_jobs.permutation
    finish_times = all_possible_order_of_jobs.map do |job_list|
      # Pass to bin pack the actual dimensions of the job
      jobs = job_list.map { |x| x==1 ? [3,5] : [2,4] }
      bin_pack_max_height(elves,jobs)
    end
    finish_times.min
  }.sum # Get the total time for all the houses
end

def bin_pack_max_height elves, jobs
  current_height = [0] * elves
  jobs.each do |package|
    # Build an internal representation of how many spaces to the right
    # and how many spaces to the left of each column are under or equal
    # to its own height
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

    # Find the left most places where the spaces available are greater or
    # equal to the width of the package
    all_columns_with_space_available_to_the_right =
        spaces_available_to_the_right.each.with_index.inject([]) { |acc,(x,i)|
          acc<<i if x >= package_width
          acc
        }

    # And then from the left_most_places_available pick the one with the
    # lowest current height
    column_with_spaces_available_to_the_right_and_min_height =
        all_columns_with_space_available_to_the_right.min { |a,b|
          current_height[a] <=> current_height[b]
        }

    # Find the actual left most place where the work package fits, by
    # shifting the position to the left as many as spaces are available
    # to the left. This is the real left-most place where the package
    # fits
    bottom_left_column =
        column_with_spaces_available_to_the_right_and_min_height -
            (spaces_available_to_the_left[
                column_with_spaces_available_to_the_right_and_min_height
            ] - 1)

    # However the new height is calculated based on the column with spaces
    # available to the_right and min height
    new_height_for_affected_columns = current_height[
        column_with_spaces_available_to_the_right_and_min_height
    ] + package_height

    # Update the current height of the affected columns, from bottom left
    # column up to the
    (bottom_left_column..(bottom_left_column+package_width-1)).each { |x|
      current_height[x] = new_height_for_affected_columns
    }
  end

  # The total length of the work is the max height
  current_height.max
end
