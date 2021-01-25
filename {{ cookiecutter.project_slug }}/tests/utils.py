from pytest import mark

describe = lambda args: mark.describe(args)
context = lambda args: mark.context(args)
when = lambda args: mark.context(args)
and_when = lambda args: mark.context(args)
it = lambda args: mark.it(args)
