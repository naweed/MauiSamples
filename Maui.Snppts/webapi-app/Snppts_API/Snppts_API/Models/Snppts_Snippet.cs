using System;
namespace Snppts_API.Models;

public class Snppts_Snippet
{
    public string Slug { get; set; }
    public string Title { get; set; }
    public string Description { get; set; }
    public string BuiltWith { get; set; }
    public string ExternalUri { get; set; }
    public string GithubUri { get; set; }
    public string AuthorGithubHandle { get; set; }
    public int GithubStars { get; set; }
    public DateTime GithubLastUpdatedDate { get; set; }
    public bool ContainsAndroidSample { get; set; }
    public bool ContainsiOSSample { get; set; }
    public bool ContainsUWPSample { get; set; }

    public List<Snppts_Category> Categories { get; set; } = new();
    public List<Snppts_Image> Images { get; set; } = new();
}

