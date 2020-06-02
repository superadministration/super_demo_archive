require "test_helper"

class DataResetsAfterFiveMinutesTest < ActionDispatch::IntegrationTest
  def test_it_resets_if_never_reset_before
    assert_equal(0, Member.all.size)

    assert_difference(-> { Reset.all.size }, 1) do
      get("/admin/members")
    end

    refute_equal(0, Member.all.size)
  end

  def test_it_resets_modifications
    get(admin_members_path)

    params = {
      member: {
        name: "William Thomas Riker",
        rank: "commander",
        position: "First Officer",
        ship_id: Ship.find_by(registry: "NCC-1701-D").id,
      },
    }

    assert_difference(-> { Member.where(name: "William T. Riker").size }, -1) do
      assert_difference(-> { Member.where(name: "William Thomas Riker").size }, 1) do
        put(admin_member_path(Member.find_by!(name: "William T. Riker")), params: params)
        follow_redirect!
        assert_equal(200, status)
      end
    end

    travel(2.minutes) do
      get(admin_members_path)
      assert(Member.find_by(name: "William Thomas Riker"))
    end

    travel(6.minutes) do
      get(admin_members_path)
      assert(Member.find_by(name: "William T. Riker"))
    end
  end

  def test_it_resets_deletions
    get(admin_members_path)

    Member.find_by!(name: "Jean-Luc Picard").destroy
    refute(Member.find_by(name: "Jean-Luc Picard"))

    travel(6.minutes) do
      get(admin_members_path)
      assert(Member.find_by(name: "Jean-Luc Picard"))
    end
  end

  def test_it_resets_creations
    get(admin_members_path)

    Member.create!(
      name: "Wesley Crusher",
      rank: "ensign",
      position: "Acting ensign",
      ship: Ship.find_by(registry: "NCC-1701-D")
    )
    assert(Member.find_by(name: "Wesley Crusher"))

    travel(6.minutes) do
      get(admin_members_path)
      refute(Member.find_by(name: "Wesley Crusher"))
    end
  end

  def test_it_cleans_out_old_resets
    15.times do |n|
      travel((-10 * (n + 1)).minutes) do
        Reset.create!
      end
    end

    get(admin_members_path)

    assert_equal(10, Reset.all.size)
  end
end
