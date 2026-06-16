page 50533 "Appraiser's Review List"
{
    // version TL2.0

    CardPageID = "Performance Review Card";
    PageType = List;
    SourceTable = 50286;
    SourceTableView = WHERE("Released to Appraiser" = FILTER('Yes'));
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
                field("Department Code"; Rec."Department Code")
                {
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
        //  SETRANGE("Appraiser Employee No.", UserSetup."Employee No.");
        Rec.FILTERGROUP(0);
    end;

    var
        UserSetup: Record 91;
}
