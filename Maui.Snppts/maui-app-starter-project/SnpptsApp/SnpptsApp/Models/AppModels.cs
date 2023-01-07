namespace SnpptsApp.Models;


public class SnpptsResult
{
    public List<Author> Authors { get; set; }
    public List<Snippet> Snippets { get; set; }
}

public class Author
{
    public string GitHubHandle { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Website { get; set; }
    public string TwitterHandle { get; set; }
    public string GravatarHash { get; set; }
}

public class Snippet
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
    public List<AppCategory> Categories { get; set; }
    public List<Image> Images { get; set; }
}

public class AppCategory
{
    public string Slug { get; set; }
    public string Category { get; set; }
}

public class Image
{
    public string Slug { get; set; }
    public string ImageUri { get; set; }
}