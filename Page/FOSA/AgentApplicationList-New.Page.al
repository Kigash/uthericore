page 50371 "Agent Application List-New"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Agent Application";
    SourceTableView = WHERE(Status = FILTER(New));
    CardPageId = 50370;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(General)
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
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }

                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Device Phone No."; Rec."Device Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Device Serial No."; Rec."Device Serial No.")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field("Business Name"; Rec."Business Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}