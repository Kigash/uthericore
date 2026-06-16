page 50430 "Performance Review Archive"
{
    // version TL2.0

    CardPageID = "Performance Review Card";
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = 50286;
    SourceTableView = WHERE("Released to HR Admin" = FILTER('Yes'));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec."Branch Name")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec."Department Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        Rec.FILTERGROUP(2);
        UserSetup.GET(USERID);
        //   SETRANGE("Appraiser Employee No.", UserSetup."Employee No.");
        Rec.FILTERGROUP(0);
    end;

    var
        UserSetup: Record 91;
}
