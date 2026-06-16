page 50146 "Mobile Bk Appl. List-Approved"
{
    // version TL2.0

    Caption = 'Approved Mobile Banking Applications';
    CardPageID = "Mobile Banking Appl. Card";
    Editable = false;
    PageType = List;
    SourceTable = "Mobile Banking Application";
    SourceTableView = WHERE(Status = FILTER(Approved));

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
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Service Type"; Rec."Service Type")
                {
                    ApplicationArea = All;
                }
                field("SMS Alert on"; Rec."SMS Alert on")
                {
                    ApplicationArea = All;
                }
                field("E-Mail Alert on"; Rec."E-Mail Alert on")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
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

