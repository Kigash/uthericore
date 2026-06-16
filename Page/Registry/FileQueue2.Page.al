page 55707 "File Queue2"
{
    // version CBS-TL,REG

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Transfer Files Line";
    //SourceTableView = WHERE(Returned= CONST(No),
    // "SentRet Note"=CONST(No));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transfer ID"; Rec."Transfer ID")
                {
                    Visible = false;
                }
                field("File Number"; Rec."File Number")
                {
                }
                field("File Name"; Rec."File Name")
                {
                    StyleExpr = StyleText;
                }
                field("Member No"; Rec."Member No")
                {
                }
                field("ID No"; Rec."ID No")
                {
                }
                field("Payroll No"; Rec."Payroll No")
                {
                }
                field("File Volume"; Rec."File Volume")
                {
                }
                field("Time Received"; Rec."Time Received")
                {
                }
                field("Due Date"; Rec."Due Date")
                {
                    StyleExpr = StyleText;
                }
                field(sentreturnnote; sentreturnnote)
                {
                    Caption = 'sentreturnnote';
                }
                field("SentRet Note"; Rec."SentRet Note")
                {
                }
                field("File No"; Rec."File No")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send Return Note")
            {
                Image = Return;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    User.GET(USERID);
                    CurrPage.SETSELECTIONFILTER(Rec);
                    IF Rec."SentRet Note" = TRUE THEN
                        ERROR('The file return note has already been sent');
                    IF CONFIRM('Are you sure you want to return this file?') THEN BEGIN
                        FileReturn.INIT;
                        FileReturn."Return ID" := '';
                        NoSetup.GET();
                        NoSetup.TESTFIELD("Return ID");
                        FileReturn."Return ID" := NoSeriesMgt.GetNextNo(NoSetup."Return ID");
                        FileReturn."Return Date" := CURRENTDATETIME;
                        FileReturn."Staff Name" := USERID;
                        FileReturn.Remarks := 'File Return';
                        FileReturn."File Return Status" := FileReturn."File Return Status"::"Pending Acceptance";
                        FileReturn."Branch Code" := User."Global Dimension 1 Code";
                        FileReturn.Posted := TRUE;
                        FileReturn."Request ID" := Rec."Request ID";
                        FileReturn.INSERT;
                        FileReturn.VALIDATE("Return ID");

                        TransferFilesLines.RESET;
                        TransferFilesLines.SETFILTER("Transfer ID", Rec."Transfer ID");
                        IF TransferFilesLines.FINDFIRST THEN BEGIN //ERROR('%1',"Transfer ID");
                            TransferFilesLines."SentRet Note" := TRUE;
                            TransferFilesLines.MODIFY;
                            COMMIT;
                        END;

                        TransferFilesLines2.INIT;
                        TransferFilesLines2."Transfer ID" := FileReturn."Return ID";
                        TransferFilesLines2."File No" := Rec."File No";
                        TransferFilesLines2."File Number" := Rec."File Number";
                        TransferFilesLines2."Member No" := Rec."Member No";
                        TransferFilesLines2."File Name" := Rec."File Name";
                        TransferFilesLines2."Member No" := Rec."Member No";
                        TransferFilesLines2."ID No" := Rec."ID No";
                        TransferFilesLines2."Payroll No" := Rec."Payroll No";
                        TransferFilesLines2."File Volume" := Rec."File Volume";
                        TransferFilesLines2."Released From" := USERID;
                        TransferFilesLines2."Time Released" := CURRENTDATETIME;
                        TransferFilesLines2."Request ID" := Rec."Request ID";
                        TransferFilesLines2."SentRet Note" := TRUE;
                        TransferFilesLines2."Carried By" := Rec."Received By";//
                        TransferFilesLines2."Due Date" := Rec."Due Date";
                        TransferFilesLines2."File Type" := Rec."File Type";
                        TransferFilesLines2.INSERT;

                        // MESSAGE('%1,%2',FileReturn."Return ID","File Name");

                        MESSAGE('File Return Note has been sent to registry under file return ID: %1,', FileReturn."Return ID");

                    END;
                end;
            }
            action("Transfer File")
            {
                Image = TransferOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    IF CONFIRM('Are you sure you want to transfer this file?') THEN BEGIN

                        //TransferRegistryFiles.RESET;
                        TransferRegistryFiles.INIT;
                        TransferRegistryFiles."Transfer ID" := '';
                        NoSetup.GET();
                        NoSetup.TESTFIELD("Transfer ID");
                        TransferRegistryFiles."Transfer ID" := NoSeriesMgt.GetNextNo(NoSetup."Transfer ID");
                        MESSAGE('%1', TransferRegistryFiles."Transfer ID");
                        TransferRegistryFiles."Released From" := USERID;
                        TransferRegistryFiles."Time Released" := CURRENTDATETIME;
                        TransferRegistryFiles.Status := TransferRegistryFiles.Status::New;
                        TransferRegistryFiles.INSERT;
                        TransferRegistryFiles.VALIDATE("Transfer ID");


                        //TransferFilesLines.RESET;
                        TransferFilesLines.INIT;
                        TransferFilesLines."Transfer ID" := TransferRegistryFiles."Transfer ID";
                        TransferFilesLines."File No" := Rec."File No";
                        TransferFilesLines."File Number" := Rec."File Number";
                        TransferFilesLines."Member No" := Rec."Member No";
                        TransferFilesLines."File Name" := Rec."File Name";
                        TransferFilesLines."Member No" := Rec."Member No";
                        TransferFilesLines."ID No" := Rec."ID No";
                        TransferFilesLines."Payroll No" := Rec."Payroll No";
                        TransferFilesLines."File Volume" := Rec."File Volume";
                        TransferFilesLines."Released From" := USERID;
                        TransferFilesLines."Time Released" := CURRENTDATETIME;
                        TransferFilesLines."Request ID" := Rec."Request ID";
                        TransferFilesLines.INSERT;
                        PAGE.RUN(74046, TransferRegistryFiles);
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        IF CURRENTDATETIME > Rec."Due Date" THEN BEGIN
            StyleText := 'Unfavorable';
            // Overdue:=TRUE;
        END;
    end;

    trigger OnOpenPage();
    begin
        User.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETRANGE("Received By", USERID);
        Rec.SETRANGE("SentRet Note", FALSE);
        Rec.FILTERGROUP(0);
        //SETRANGE("Released To",USERID);
        //SETRANGE("Time Received",0T);
    end;

    var
        User: Record "User Setup";
        Overdue: Boolean;
        StyleText: Text[20];
        FileReturn: Record "File Return";
        TransferFilesLines: Record "Transfer Files Line";
        NoSetup: Record "Registry SetUp";
        NoSeriesMgt: Codeunit "No. Series";
        sentreturnnote: Boolean;
        TransferRegistryFiles: Record "Transfer Registry File";
        TransferFilesLines2: Record "Transfer Files Line";
}

