using System;
namespace Snppts_API.Models;

public class Snppts_Result
{
    public List<Snppts_Author> Authors { get; set; }
    public List<Snppts_Snippet> Snippets { get; set; }
}

