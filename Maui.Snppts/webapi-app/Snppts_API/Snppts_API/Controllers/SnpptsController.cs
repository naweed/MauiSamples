using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Snppts_API.Models;
using XGENO.DBHelpers.Extensions;

namespace Snppts_API.Controllers;

[Route("api/snppts/v.1.0")]
public class SnpptsController : Controller
{
    private const string DB_Connection_String =
        "Server=localhost;Database=Snppts_DB;Uid=naweed;Password=bigStrongPwd$;TrustServerCertificate=True;";


    [HttpGet("snippets")]
    public async Task<IActionResult> GetAllSnippets()
    {
        try
        {
            return Ok(await GetSnippetsFromDB());
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"SnpptsAPI: A problem occured while handling your request. Please try agian later.");
        }
    }

    private async Task<Snppts_Result> GetSnippetsFromDB()
    {
        //Declare the result variable
        var snpptsResult = new Snppts_Result();

        using (SqlConnection dbConn = new SqlConnection(DB_Connection_String))
        {
            //Open DB connection
            dbConn.Open();

            //Execute stored procedure to get data from database
            var multiResults = await dbConn.ExecuteMultiResultStoredProcedure("sp_Get_All_Snippets");

            //The first resultset returns list of all authors
            snpptsResult.Authors = multiResults.Read<Snppts_Author>();

            //The second resultset returns list of all snippets
            snpptsResult.Snippets = multiResults.Read<Snppts_Snippet>();

            //The third resultset returns list of all images (across all snippets)
            var imagesList = multiResults.Read<Snppts_Image>();

            //The fourth resultset returns list of all categories (across all snippets)
            var categoriesList = multiResults.Read<Snppts_Category>();


            //For each of the snippet:
            foreach (var snippet in snpptsResult.Snippets)
            {
                // 1. Add images for this snippet as sub list
                if (imagesList.Any(x => x.Slug == snippet.Slug))
                    snippet.Images = imagesList.Where(x => x.Slug == snippet.Slug).ToList();

                // 2. Add categories for this snippet as sub list
                if (categoriesList.Any(x => x.Slug == snippet.Slug))
                    snippet.Categories = categoriesList.Where(x => x.Slug == snippet.Slug).ToList();
            }

            //Close DB connection
            dbConn.Close();
        }

        //Return the result as JSON
        return snpptsResult;
    }
}

