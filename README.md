# bitv: BitVectors for Fun and Profit

Ever find yourself transmitting vast numbers of "flags" as variables in a JSON
payload? Or, even worse, doing boolean calculations over and over on the client
side? If so, `bitv` is here for you: use server-side precalculation to
determine various flags for a set of entities, communicate them as simple
arrays of integers in your JSON payload, and use bitwise operators in
JavaScript to perform filtering quickly on the client side.

# Ruby Example (with no JS)

    > bv = BitVector.new([:a, :b, :c, :d, :e, :f])
     => #<BitVector:0x00000001873100 @possibilities=[:a, :b, :c, :d, :e, :f]> 
    > bv.targets = {argyle: [:a, :c], polka_dot: [:b, :c, :d], stripes: [:d, :e], solid: [:b, :e, :f]}
     => {:argyle=>[:a, :c], :polka_dot=>[:b, :c, :d], :stripes=>[:d, :e], :solid=>[:b, :e, :f]} 
    > puts bv.json
    {"vectorLength":1,"possibilities":{"a":[0,1],"b":[0,2],"c":[0,4],"d":[0,8],"e":[0,16],"f":[0,32]},"targets":{"argyle":[5],"polka_dot":[14],"stripes":[24],"solid":[50]}}
    > bv.targets_matching :b
     => [:polka_dot, :solid] 
    > bv.targets_matching :b, :a
     => [] 
    > bv.targets_matching :b, :c
     => [:polka_dot] 
