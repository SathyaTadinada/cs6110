predicate sorted(a:seq<int>)
{ forall i,j :: 0 <= i < j < |a| ==> a[i] <= a[j] }

method InsertionSort(a:array<int>)
  modifies a
  requires a.Length >= 2
  ensures sorted(a[..])
  ensures multiset(a[..]) == multiset(old(a[..]))
{
  var x := 1;
  while x < a.Length
    invariant 1 <= x <= a.Length
    invariant sorted(a[..x])
    invariant multiset(a[..]) == multiset(old(a[..]))
  {
    var d := x;
    while d >= 1 && a[d-1] > a[d]
      invariant 0 <= d <= x
      invariant forall i :: d < i <= x ==> a[d] <= a[i]
      invariant forall i, j :: 0 <= i < j <= x && i != d && j != d ==> a[i] <= a[j]
      invariant multiset(a[..]) == multiset(old(a[..]))
    {
      a[d-1], a[d] := a[d], a[d-1];
      d := d - 1;
    }
    x := x + 1;
  }
}