# bitv: BitVectors for Fun and Profit

Ever find yourself transmitting vast numbers of "flags" as variables in a JSON
payload? Or, even worse, doing boolean calculations over and over on the client
side? If so, `bitv` is here for you: use server-side precalculation to
determine various flags for a set of entities, communicate them as simple
arrays of integers in your JSON payload, and use bitwise operators in
JavaScript to perform filtering quickly on the client side.
