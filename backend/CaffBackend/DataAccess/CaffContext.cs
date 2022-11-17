using DataAccess.Constants;
using DataAccess.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace DataAccess
{
    public class CaffContext : IdentityDbContext<User>
    {
        public CaffContext(DbContextOptions<CaffContext> options) : base(options)
        {
        }

        public DbSet<CaffFile> CaffFiles { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<Tag> Tags { get; set; }
        public DbSet<User> Users { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            
            modelBuilder.Entity<IdentityRole>().HasData(
                new IdentityRole { Name = UserRoleConstants.Admin, NormalizedName = UserRoleConstants.Admin.ToUpper() },
                new IdentityRole { Name = UserRoleConstants.User, NormalizedName = UserRoleConstants.User.ToUpper() }
            );

            modelBuilder.Entity<CaffFile>()
                .HasMany(c => c.Tags)
                .WithOne(t => t.CaffFile)
                .HasForeignKey(t => t.CaffFileId)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<CaffFile>()
                .HasMany(c => c.Comments)
                .WithOne(c => c.CaffFile)
                .HasForeignKey(c => c.CaffFileId)
                .OnDelete(DeleteBehavior.Cascade); 

            modelBuilder.Entity<User>()
                .HasMany(u => u.Comments)
                .WithOne(c => c.Commenter)
                .HasForeignKey(c => c.CommenterId)
                .OnDelete(DeleteBehavior.Cascade); 

            modelBuilder.Entity<User>()
                .HasMany(u => u.UploadedCaffFiles)
                .WithOne(c => c.Uploader)
                .HasForeignKey(c => c.UploaderId)
                .OnDelete(DeleteBehavior.Restrict);
        }
    }
}