page 50805 "Procurement Methods List"
{

    PageType = List;
    SourceTable = "Procurement Method";
    Caption = 'Procurement Methods List';
    CardPageId = "Procurement Methods";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Method; Rec.Method)
                {
                    ApplicationArea = All;
                }
                field("Award Approval"; Rec."Award Approval")
                {
                    ApplicationArea = All;
                }
                field("Closing Period"; Rec."Closing Period")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
