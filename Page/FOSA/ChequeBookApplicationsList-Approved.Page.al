page 50174 "ChequeBook Appl. List-Approved"
{
    // version TL2.0

    Caption = 'Approved Cheque Book Applications';
    CardPageID = "Cheque Book Application";
    PageType = List;
    SourceTable = "Cheque Book Application";
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
                field(Description; Rec.Description)
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
                field("Cheque Book No."; Rec."Cheque Book No.")
                {
                    ApplicationArea = All;
                }
                field("Cheque Book S/No."; Rec."Cheque Book S/No.")
                {
                    ApplicationArea = All;
                }
                field("No. of Leaves"; Rec."No. of Leaves")
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
                field("Account Balance"; Rec."Account Balance")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Approved By"; Rec."Approved By")
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

