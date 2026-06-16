page 50822 "Requisitions List"
{

    Caption = 'Requisitions List';
    PageType = List;
    SourceTable = "Requisition Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                }
                field("Requisition Date"; Rec."Requisition Date")
                {
                    ApplicationArea = All;
                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
