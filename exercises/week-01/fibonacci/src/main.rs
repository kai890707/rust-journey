fn main() {
    
    let mut base0 = 0;
    let mut base1 = 1;

    let mut n = String::new();
    std::io::stdin()
        .read_line(&mut n)
        .expect("error");
    let n: u32 = n.trim().parse().expect("error");

    for _ in 0..n {
        let next = base0 + base1;
        println!("{next}");
        base0 = base1;
        base1 = next;
    }
}
