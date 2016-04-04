#1  
a = 1

#2 
an array is a collection of elements that are indexed from 0 to n.
a hash is collection of key-value pairs in which the value is accessed
by using the key of the pair. Hashes are generally in no specific order
while arrays are ordered by their index value.

#3  
1 => [1, 2, 3, 3]
2 => [1, 2, 3]
3 => [1, 2, 3]

#4
.map returns an array in which each element has been modified 
by whatever expressions are contained within the block that follows it
select returns an array containing all the elements from the 
array on which .select was called that evaluate to true within the 
block that follows .select

I would use .select when I wanted a subset an array that met certain criteria.
I would use .map when I wanted to modify each element in a certain way.

#5
You would use the old-style method of creating a hash.  {"string" => "cheese"}

#6
"no way!" would be returned which would be actually be incorrect

#7
4

#8
error message. x is not known outside of the do end block.