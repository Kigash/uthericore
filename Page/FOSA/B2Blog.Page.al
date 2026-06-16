page 50396 "B2B logs"
{
    PageType = List;
    SourceTable = "B2B logs";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Amount Transacted"; Rec."Amount Transacted")
                {
                    ApplicationArea = All;
                }
                field("Tax Charged"; Rec."Tax Charged")
                {
                    ApplicationArea = All;
                }
                field("Coop Commission"; Rec."Coop Commission")
                {
                    ApplicationArea = All;
                }
                field("Tl Commission"; Rec."Tl Commission")
                {
                    ApplicationArea = All;
                }
                field("Sacco Commission"; Rec."Sacco Commission")
                {
                    ApplicationArea = All;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                }
                field("Reference Number"; Rec."Reference Number")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
                field("Transcation Reference"; Rec."Transcation Reference")
                {
                }
            }
        }
    }

    actions
    {
    }
}

