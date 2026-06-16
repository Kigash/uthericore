page 50342 "Member Agencies"
{
    // version TL2.0

    //Editable = false;
    PageType = List;
    SourceTable = "Member Agency";
    UsageCategory = Lists;
    ApplicationArea = All;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Agent Name"; Rec."Agent Name")
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Agency No."; Rec."Member Agency No.")
                {
                    ApplicationArea = All;
                }
                field("Payroll No."; Rec."Payroll No.")
                {
                    ApplicationArea = All;
                }
                field("Pay To Account No."; Rec."Pay To Account No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

