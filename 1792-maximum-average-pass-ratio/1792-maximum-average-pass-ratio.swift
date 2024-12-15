class Solution {
    func maxAverageRatio(_ classes: [[Int]], _ extraStudents: Int) -> Double {
        class Class {
            var pass: Double
            var total: Double
            var cost: Double { (pass + 1) / (total + 1) - pass / total }
            var ratio: Double { pass / total }

            init(_ p: Int, _ t: Int) {
                pass = Double(p)
                total = Double(t)
            }
        }
        
        class Heap {
            var data = [Class]()

            func push(_ c: Class) {
                data.append(c)
                shiftUp(data.count - 1)
            }

            func shiftUp(_ i: Int) {
                guard i > 0 else { return }
                let p = (i - 1) / 2
                guard data[p].cost < data[i].cost else { return }
                data.swapAt(p, i)
                shiftUp(p)
            }

            func shiftDown(_ i: Int) {
                let l = 2 * i + 1
                let r = 2 * i + 2
                var m = i
                if l < data.count, data[l].cost > data[m].cost { m = l }
                if r < data.count, data[r].cost > data[m].cost { m = r }
                guard m != i else { return }
                data.swapAt(m, i)
                shiftDown(m)
            }
        }

        let h = Heap()
        var e = extraStudents

        for c in classes {
            h.push(Class(c[0], c[1]))
        }

        while e > 0 {
            h.data[0].pass += 1
            h.data[0].total += 1
            h.shiftDown(0)
            e -= 1
        }

        return h.data.reduce(0, { $0 + $1.ratio }) / Double(classes.count)
    }
}